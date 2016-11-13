package grupo_5.unq.edu.ar.rankit_mobile;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import model.Calificacion;


/**
 * An activity representing a single Libro detail screen. This
 * activity is only used on handset devices. On tablet-size devices,
 * item details are presented side-by-side with a list of items
 * in a {@link CalificacionListActivity}.
 * <p/>
 * This activity is mostly just a 'shell' activity containing nothing
 * more than a {@link CalificacionDetailFragment}.
 */
public class CalificacionDetailActivity extends ActionBarActivity {


    CalificacionDetailFragment fragment;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_libro_detail);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        // Show the Up button in the action bar.
        //getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        // savedInstanceState is non-null when there is fragment state
        // saved from previous configurations of this activity
        // (e.g. when rotating the screen from portrait to landscape).
        // In this case, the fragment will automatically be re-added
        // to its container so we don't need to manually add it.
        // For more information, see the Fragments API guide at:
        //
        // http://developer.android.com/guide/components/fragments.html
        //
        if (savedInstanceState == null) {
            // Create the detail fragment and add it to the activity
            // using a fragment transaction.
            Bundle arguments = new Bundle();
            arguments.putString(CalificacionDetailFragment.ID,
                    getIntent().getStringExtra(CalificacionDetailFragment.ID));
             fragment = new CalificacionDetailFragment();
            fragment.setArguments(arguments);
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.libro_detail_container, fragment)
                    .commit();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_opciones,menu);
        return  true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.home:
                NavUtils.navigateUpTo(this, new Intent(this, CalificacionListActivity.class));
                break;
            case R.id.editarCalificacion:
                this.editarCalificacionSeleccionada();
                break;
            case R.id.eliminarCalificacion:
                break;

        }
       /* int id = item.getItemId();
        if (id == android.R.id.home) {
            // This ID represents the Home or Up button. In the case of this
            // activity, the Up button is shown. Use NavUtils to allow users
            // to navigate up one level in the application structure. For
            // more details, see the Navigation pattern on Android Design:
            //
            // http://developer.android.com/design/patterns/navigation.html#up-vs-back
            //
            NavUtils.navigateUpTo(this, new Intent(this, CalificacionListActivity.class));
            return true;
        }
        */
        return super.onOptionsItemSelected(item);
    }

    public void editarCalificacionSeleccionada(){


        Intent detailIntent = new Intent(this, EditarCalificacionActivity.class);
        detailIntent.putExtra(CalificacionDetailFragment.NOMBRE, fragment.calificacionSeleccionada.getEvaluado().getNombre());
        detailIntent.putExtra(CalificacionDetailFragment.ID, fragment.calificacionSeleccionada.getId());
        detailIntent.putExtra(CalificacionDetailFragment.PUNTOS, fragment.calificacionSeleccionada.getPuntos());
        detailIntent.putExtra(CalificacionDetailFragment.MOTIVO, fragment.calificacionSeleccionada.getDetalle());
        startActivity(detailIntent);



    }

}
